import Foundation
import XCTestDynamicOverlay


public struct Response { }

public struct Demo<T> {

  // swiftlint:disable identifier_name
  var _first: () async throws -> Response
  var _third: (String) async throws -> Response
  var _fourth: ( String, String,  String) async throws -> Response
  var _fifth: () -> Response?
  var _sixth: () async throws -> Response
  // swiftlint:enable identifier_name

  public init(
    first: @escaping () async throws -> Response,
    third: @escaping (String) -> Response,
    fourth: @escaping (String, String, String) -> Response,
    fifth: @escaping () -> Response?,
    sixth: @escaping () -> Response
  ) {
    self._first = first
    self._third = third
    self._fourth = fourth
    self._fifth = fifth
    self._sixth = sixth
  }

  public func first() async throws -> Response {
    try await self._first()
  }

  public func fourth(par1: String, par2: String, par3: String) async throws -> Response {
    try await self._fourth(par1, par2, par3)
  }

  public func third(with code: String) async throws -> Response {
    try await self._third(code)
  }

  public func fifth() -> Response? {
    self._fifth()
  }

  public func sixth() async throws -> Response {
    try await self._sixth()
  }
}

// MARK: - noop

extension Demo {
  public static func noop(T: T) -> Self {
    let mock = Response.init()
    return .init(
      first: { mock },
      third: { _ in mock },
      fourth: { _, _, _ in mock },
      fifth: { .none },
      sixth: { mock }
    )
  }
}

// MARK: - failing

#if DEBUG
  extension Demo {
    public static func failing(T: T) -> Self {
      let mock = Response.init()
      return .init(
        first: XCTUnimplemented("\(Self.self).first"),
        third: XCTUnimplemented("\(Self.self).third"),
        fourth: XCTUnimplemented("\(Self.self).fourth"),
        fifth: XCTUnimplemented("\(Self.self).fifth"),
        sixth: XCTUnimplemented("\(Self.self).sixth"))
    }
  }
#endif
