
"use strict";

let TestEmpty = require('./TestEmpty.js')
let TestMultipleResponseFields = require('./TestMultipleResponseFields.js')
let TestNestedService = require('./TestNestedService.js')
let SendBytes = require('./SendBytes.js')
let TestResponseOnly = require('./TestResponseOnly.js')
let TestRequestAndResponse = require('./TestRequestAndResponse.js')
let TestRequestOnly = require('./TestRequestOnly.js')
let AddTwoInts = require('./AddTwoInts.js')
let TestMultipleRequestFields = require('./TestMultipleRequestFields.js')
let TestArrayRequest = require('./TestArrayRequest.js')

module.exports = {
  TestEmpty: TestEmpty,
  TestMultipleResponseFields: TestMultipleResponseFields,
  TestNestedService: TestNestedService,
  SendBytes: SendBytes,
  TestResponseOnly: TestResponseOnly,
  TestRequestAndResponse: TestRequestAndResponse,
  TestRequestOnly: TestRequestOnly,
  AddTwoInts: AddTwoInts,
  TestMultipleRequestFields: TestMultipleRequestFields,
  TestArrayRequest: TestArrayRequest,
};
