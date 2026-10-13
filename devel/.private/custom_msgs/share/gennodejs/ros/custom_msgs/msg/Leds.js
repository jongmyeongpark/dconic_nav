// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ColorRGB = require('./ColorRGB.js');

//-----------------------------------------------------------

class Leds {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.colors = null;
      this.color_code = null;
    }
    else {
      if (initObj.hasOwnProperty('colors')) {
        this.colors = initObj.colors
      }
      else {
        this.colors = [];
      }
      if (initObj.hasOwnProperty('color_code')) {
        this.color_code = initObj.color_code
      }
      else {
        this.color_code = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Leds
    // Serialize message field [colors]
    // Serialize the length for message field [colors]
    bufferOffset = _serializer.uint32(obj.colors.length, buffer, bufferOffset);
    obj.colors.forEach((val) => {
      bufferOffset = ColorRGB.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [color_code]
    bufferOffset = _serializer.uint8(obj.color_code, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Leds
    let len;
    let data = new Leds(null);
    // Deserialize message field [colors]
    // Deserialize array length for message field [colors]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.colors = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.colors[i] = ColorRGB.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [color_code]
    data.color_code = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 3 * object.colors.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Leds';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5ff7e71a7764a4d0c3311bce28a43225';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    custom_msgs/ColorRGB[] colors
    uint8 color_code
    ================================================================================
    MSG: custom_msgs/ColorRGB
    uint8 r
    uint8 g
    uint8 b
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Leds(null);
    if (msg.colors !== undefined) {
      resolved.colors = new Array(msg.colors.length);
      for (let i = 0; i < resolved.colors.length; ++i) {
        resolved.colors[i] = ColorRGB.Resolve(msg.colors[i]);
      }
    }
    else {
      resolved.colors = []
    }

    if (msg.color_code !== undefined) {
      resolved.color_code = msg.color_code;
    }
    else {
      resolved.color_code = 0
    }

    return resolved;
    }
};

module.exports = Leds;
