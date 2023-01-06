# validator_dart

This library is written entirely in pure Dart code, it includes a range of validation and sanitization functions that can be easily integrated into your project.

This library is a port of the popular [validator.js](https://github.com/validatorjs/validator.js) library and includes all of its features. It has been thoroughly tested with unit tests and is generally stable. However, there may be some performance issues or bugs that are not covered by the unit tests. Therefore, it is recommended to thoroughly test this library in your own environment before using it in production. 

A big shoutout to the amazing author and contributors of the original validator.js library - this library wouldn't exist without their hard work and dedication. While it will continue to closely follow the design and functionality of the original library, it will also extend upon it by adding new features and improvements.

## Installation 

With Dart:
```
dart pub add validator_dart
```

With Flutter:
```
flutter pub add validator_dart
```

# Usage

```
var isEmail = Validator.isEmail('test@gmail.com');
print(isEmail); // true

var isPostalCode = Validator.isPostalCode('99950', 'US');
print(isPostalCode); // true
```

For additional examples, please refer to the test folder.

## Test
To run the tests for this library, you can either use your preferred IDE or use the command in the terminal. 

```
dart test
```

## TODO
 - **Clean up and refactor:** Code was ported quickly with a focus on getting it to run, rather than on maintainability.
 - **Add documentation:** Existing documentation is not following Dart guidelines.

## Maintainers

- [Almis90](https://github.com/Almis90) Almis Baimpourntidis (author)


## License (MIT)

```
MIT License

Copyright (c) 2022 Almis Solutions

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
