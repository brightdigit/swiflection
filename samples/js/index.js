myprotocol = function () {

};

myclass = new myprotocol ();

myclass.prototype = {
  helloWorld : function () {
    console.log("hello world");
  }
};

var variables = global || window || this;

for (var name in variables) {
  console.log(name + ": " + global.hasOwnProperty(name));
}