// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of dart.convert;

/**
 * A [Converter] converts data from one representation into another.
 *
 * *Converters are still experimental and are subject to change without notice.*
 *
 */
abstract class Converter<S, T> {
  /**
   * Converts [input] and returns the result of the conversion.
   */
  T convert(S input);

  /**
   * Fuses `this` with [other].
   *
   * Encoding with the resulting converter is equivalent to converting with
   * `this` before converting with `other`.
   */
  Converter<S, dynamic> fuse(Converter<T, dynamic> other) {
    return new _FusedConverter<S, T, dynamic>(this, other);
  }
}

/**
 * Fuses two converters.
 *
 * For a non-chunked conversion converts the input in sequence.
 */
class _FusedConverter<S, M, T> extends Converter<S, T> {
  final Converter _first;
  final Converter _second;

  _FusedConverter(this._first, this._second);

  T convert(S input) => _second.convert(_first.convert(input));
}
