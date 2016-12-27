import 'dart:html';
import 'package:angular2/core.dart';

@Component(
  selector: 'hello-world',
  templateUrl: 'hello_world.html',
  styleUrls: const ['hello_world.css'],
)
class HelloWorldComponent {
  @Input()
  String firstName;

  String greeting = 'Hello';
  String message;

  onClick() {
    greeting = greeting == 'Hello' ? 'Howdy' : 'Hello';
  }

  onKeyUp(KeyboardEvent e) {
    if (e.keyCode == 13) {
      message = message == null ? "This is a message" : null;
    }
  }
}
