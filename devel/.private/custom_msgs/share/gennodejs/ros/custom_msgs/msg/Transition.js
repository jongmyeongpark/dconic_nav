// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let State = require('./State.js');

//-----------------------------------------------------------

class Transition {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.in = null;
      this.out = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('in')) {
        this.in = initObj.in
      }
      else {
        this.in = new State();
      }
      if (initObj.hasOwnProperty('out')) {
        this.out = initObj.out
      }
      else {
        this.out = new State();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Transition
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [in]
    bufferOffset = State.serialize(obj.in, buffer, bufferOffset);
    // Serialize message field [out]
    bufferOffset = State.serialize(obj.out, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Transition
    let len;
    let data = new Transition(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [in]
    data.in = State.deserialize(buffer, bufferOffset);
    // Deserialize message field [out]
    data.out = State.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    length += State.getMessageSize(object.in);
    length += State.getMessageSize(object.out);
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Transition';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e8262dc49d6d86b1edcd11009f8370e8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    State in
    State out
    ================================================================================
    MSG: custom_msgs/State
    string name
    string progress
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Transition(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.in !== undefined) {
      resolved.in = State.Resolve(msg.in)
    }
    else {
      resolved.in = new State()
    }

    if (msg.out !== undefined) {
      resolved.out = State.Resolve(msg.out)
    }
    else {
      resolved.out = new State()
    }

    return resolved;
    }
};

module.exports = Transition;
