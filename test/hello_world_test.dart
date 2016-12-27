@TestOn('browser')
library hello_world_test;

import 'dart:html';
import 'dart:js';
import 'package:ng2_testing/c/hello_world/hello_world.dart';
import 'package:test/test.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/src/core/reflection/reflection_capabilities.dart';
import 'package:angular2/src/modules/testing/lib/testing.dart';

void main() {
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  tearDown(() => disposeAnyRunningTest());

  group('HelloWorldComponent', () {
    NgTestBed<HelloWorldComponent> testBed;
    NgTestFixture<HelloWorldComponent> fixture;
    ParagraphElement p;
    InputElement ie;
    DivElement messageDiv;
    CssStyleDeclaration pStyle;

    setUp(() async {
      testBed = new NgTestBed<HelloWorldComponent>();
      fixture = await testBed.create(onLoad: (c) {
        c.firstName = 'fn';
        c.greeting = 'Hello';
      });
      p = fixture.element.querySelector('p');
      pStyle = p.getComputedStyle();
      ie = fixture.element.querySelector('input');
      messageDiv = fixture.element.querySelector('div.message');
    });

    test('should show the greeting as "Greeting Name"', () {
      expect(p.text, equals('Hello fn'));
    });

    test('clicking should change the greeting from Hello to Howdy', () async {
      await fixture.update((c) {
        c.onClick();
      });

      expect(p.text, equals('Howdy fn'));
    });

    test('clicking twice should restore the greeting to its original state',
        () async {
      await fixture.update((c) {
        c.onClick();
        c.onClick();
      });

      expect(p.text, equals('Hello fn'));
    });

    test('expect the <p> tag to have a background color of whitesmoke', () {
      expect(pStyle.backgroundColor, equals('rgb(245, 245, 245)'));
    });

    test('message should respond to enter key', () async {
      expect(messageDiv, isNull);

      KeyEvent e = new KeyEvent('keyup', keyCode: 13);

      await fixture.update((c) {
        c.onKeyUp(e);
      });
      messageDiv = fixture.element.querySelector('div.message');

      expect(messageDiv, isNotNull);
      expect(messageDiv.text, 'This is a message');

      await fixture.update((c) {
        c.onKeyUp(e);
      });
      messageDiv = fixture.element.querySelector('div.message');

      expect(messageDiv, isNull);
    });
  });
}
