import * as THREE from "three"

export default function getAsteroids({ numAsteroids = 50 } = {}) {
  const group = new THREE.Group();
  
  // Base geometry for asteroids: an icosahedron gives a rough sphere
  const baseGeometry = new THREE.IcosahedronGeometry(1, 1);

  for (let i = 0; i < numAsteroids; i++) {
    // Clone the base geometry for each asteroid
    const asteroidGeometry = baseGeometry.clone();
    const positionAttribute = asteroidGeometry.attributes.position;
    const vertexCount = positionAttribute.count;

    // Randomly displace each vertex for an irregular, rocky appearance
    for (let j = 0; j < vertexCount; j++) {
      const x = positionAttribute.getX(j);
      const y = positionAttribute.getY(j);
      const z = positionAttribute.getZ(j);
      // Multiply vertices by a random scalar to create small variations
      const displacement = 1 + (Math.random() - 0.5) * 0.4; // vary by +-20%
      positionAttribute.setXYZ(j, x * displacement, y * displacement, z * displacement);
    }
    // Update normals after modifying geometry
    asteroidGeometry.computeVertexNormals();

    // Create an asteroid material with flat shading for a rugged look
    const material = new THREE.MeshStandardMaterial({
      color: 0x555555,
      roughness: 0.9,
      flatShading: true,
    });

    const asteroid = new THREE.Mesh(asteroidGeometry, material);

    // Random scale between 0.5 to 2.5
    const scale = Math.random() * 2 + 0.5;
    asteroid.scale.set(scale, scale, scale);

    // Position asteroids randomly within a large volume
    asteroid.position.set(
      (Math.random() - 0.5) * 100,
      (Math.random() - 0.5) * 100,
      (Math.random() - 0.5) * 100
    );

    // Give each asteroid a random rotation
    asteroid.rotation.set(
      Math.random() * Math.PI,
      Math.random() * Math.PI,
      Math.random() * Math.PI
    );

    group.add(asteroid);
  }

  return group;
}
