# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "three", to: "https://unpkg.com/three@0.143.0/build/three.module.js"
pin "OrbitControls", to: "https://unpkg.com/three@0.143.0/examples/jsm/controls/OrbitControls.js"
pin "moment", to: "https://cdn.skypack.dev/moment"
#pin "momentjs-rails", to: "moment.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin "getStarfield", to: "controllers/src/getStarfield.js"
pin "getFresnelMat", to: "controllers/src/getFresnelMat.js"
pin "getDate", to: "controllers/src/getDate.js"
pin "getAsteroids", to: "controllers/src/getAsteroids.js"