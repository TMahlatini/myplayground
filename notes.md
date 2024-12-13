rails g stimulus <controller_name> #stimulus is a framework for building reactive interfaces.
- example: rails g stimulus threejs
- this will create a new controller in app/javascript/controllers/<controller_name>_controller.js
- this will also create a new entry in the importmap.rb file

you can render a stimulus controller in your views by using the content_tag method.

- example: <%= content_tag(:canvas, "", data: { controller: "threejs" }) %>
- this will create a new canvas element in the DOM and attach the threejs controller to it.
