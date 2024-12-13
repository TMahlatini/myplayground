import { Controller } from "@hotwired/stimulus"
import * as THREE from "three"
import { OrbitControls } from "OrbitControls"
import getStarfield  from "getStarfield";
import { getFresnelMat } from "getFresnelMat";
import  displayDaysSinceLaunch  from "getDate";

// Connects to data-controller="earth"
export default class extends Controller {
  static targets = ["canvasContainer"]
  connect() {
    console.log("Earth Controller connected");

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

    
    

    //earth group
    this.earthGroup = new THREE.Group();
    this.earthGroup.rotation.z = -23.4 * Math.PI / 180;
    this.scene.add(this.earthGroup);
    
    //textures
    this.loader = new THREE.TextureLoader()
    this.geometry = new THREE.IcosahedronGeometry(1.0,12 );
    this.material = new THREE.MeshPhongMaterial({
      map: this.loader.load("/images/earthmap.jpg"),
      specularMap: this.loader.load("/images/earthspec1k.jpg"),
      bumpMap: this.loader.load("/images/earthbump1k.jpg"),
      bumpScale: 0.04,
    });
  

    this.earthMesh = new THREE.Mesh(this.geometry, this.material);
    this.earthGroup.add(this.earthMesh);

    this.lightMat = new THREE.MeshBasicMaterial({
      map: this.loader.load("/images/earthlights.jpg"),
      blending: THREE.AdditiveBlending,
    });
    this.lightMesh = new THREE.Mesh(this.geometry, this.lightMat);
    this.earthGroup.add(this.lightMesh);

    this.cloudsMat = new THREE.MeshStandardMaterial({
      map: this.loader.load("/images/earthcloudmap.jpg"),
      transparent: true,
      opacity: 0.8,
      blending: THREE.AdditiveBlending,
      alphaMap: this.loader.load("/images/earthcloudmaptrans.jpg"),
    });
    this.cloudsMesh = new THREE.Mesh(this.geometry, this.cloudsMat);
    this.cloudsMesh.scale.setScalar(1.003);
    this.earthGroup.add(this.cloudsMesh);

    this.glowMat = getFresnelMat();
    this.glowMesh = new THREE.Mesh(this.geometry, this.glowMat);
    this.glowMesh.scale.setScalar(1.01);
    this.earthGroup.add(this.glowMesh);

    this.stars = getStarfield({numStars: 2000});
    this.scene.add(this.stars);
    this.sunLight = new THREE.DirectionalLight(0xffffff, 0.8);
    this.sunLight.position.set(-2, 0.5, 1.5);
    this.scene.add(this.sunLight);


    this.animate();
    this.displayDaysSinceLaunch = displayDaysSinceLaunch.bind(this);
    this.displayDaysSinceLaunch();


  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));
    this.earthMesh.rotation.y += 0.002;
    this.lightMesh.rotation.y += 0.002;
    this.cloudsMesh.rotation.y += 0.0023;
    this.glowMesh.rotation.y += 0.002;
    this.stars.rotation.y -= 0.0002;
    this.renderer.render(this.scene, this.camera);
    this.controls.update();
    
  }

 

}

