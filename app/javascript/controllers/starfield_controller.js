import { Controller } from "@hotwired/stimulus"
import * as THREE from "three"
import getStarfield from "getStarfield"
import getAsteroids from "./src/getAsteroids"
import { OrbitControls } from "OrbitControls"


export default class extends Controller {
  static targets = ["canvasContainer"]
  connect() {
    console.log("Starfield Controller connected");

    const w = window.innerWidth;
    const h = window.innerHeight;

    this.renderer = new THREE.WebGLRenderer({antialias: true});
    this.renderer.setSize(w, h);
    this.canvasContainerTarget.appendChild(this.renderer.domElement);

    this.renderer.toneMapping = THREE.ACESFilmicToneMapping;
    this.renderer.outputColorSpace = THREE.SRGBColorSpace;

    const fov = 75; //field of view 
    const aspect = w / h;  //aspect ratio 
    const near = 0.1; //near clipping plane. 
    const far = 1000; //far clipping plane

    this.camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
    this.camera.position.z  = 5;  
    this.scene = new THREE.Scene();



    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    this.controls.enableDamping = true;
    this.controls.enableZoom = true;
    this.controls.maxDistance = 50;
    this.controls.minDistance = 2;

    this.starfield = getStarfield({numStars: 2000});
    this.scene.add(this.starfield);
    this.sunLight = new THREE.DirectionalLight(0xffffff, 0.8);
    this.sunLight.position.set(-2, 0.5, 1.5);
    this.scene.add(this.sunLight);

    // Add asteroids to the scene
    this.asteroids = getAsteroids({ numAsteroids: 50 });
    this.scene.add(this.asteroids);

    this.animate();
  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));
    this.starfield.rotation.y += 0.0001;
    this.asteroids.rotation.y += 0.0005;
    this.renderer.render(this.scene, this.camera);
    this.controls.update();
  }
}
