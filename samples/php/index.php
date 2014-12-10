<?php
interface myprotocol {
  public function helloWorld();
}

class myclass implements myprotocol {
  public function helloWorld() {
    echo "hello world";
  }
}

$all_classes = get_declared_classes();
$myprotocol_classes = array_values(array_filter($all_classes, function ($class) {
  return in_array("myprotocol", class_implements($class));
}));
print_r($myprotocol_classes);
$class = $myprotocol_classes[0];
$instance = new $class();
$instance->helloWorld();
?>