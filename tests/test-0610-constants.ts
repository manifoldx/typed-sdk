"use strict";

import { describe, it } from "mocha";
import { expect } from "chai";
import { manifold, errors } from "../src.ts/index";
import { nodeProvider } from "./env";

let indent = "     ";
let silent = true;

describe("Suite: Constants", function () {
  if (silent) {
    silent = nodeProvider.trace.silent;
  }

  it("version", function () {
    let version = manifold.version;
    expect(version).to.exist;
    if (!silent) console.log(indent, "Version:", version);
  });

  it("error version", function () {
    let error = errors.createError("Hello bugs", errors.NOT_FOUND, {});
    expect(error).to.exist;
    expect(error.toString()).is.eq(
      "Error: Hello bugs (version=" + manifold.version + ")"
    );
    if (!silent) console.log(indent, "Error:", error);
  });

  it("constant variables should exists", function () {
    let constants = manifold.constants;
    expect(constants).to.exist;
  });
});
