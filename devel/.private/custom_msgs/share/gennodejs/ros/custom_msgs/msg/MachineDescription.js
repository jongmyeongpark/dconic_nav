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
let Transition = require('./Transition.js');

//-----------------------------------------------------------

class MachineDescription {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.states = null;
      this.transitions = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('states')) {
        this.states = initObj.states
      }
      else {
        this.states = [];
      }
      if (initObj.hasOwnProperty('transitions')) {
        this.transitions = initObj.transitions
      }
      else {
        this.transitions = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MachineDescription
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [states]
    // Serialize the length for message field [states]
    bufferOffset = _serializer.uint32(obj.states.length, buffer, bufferOffset);
    obj.states.forEach((val) => {
      bufferOffset = State.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [transitions]
    // Serialize the length for message field [transitions]
    bufferOffset = _serializer.uint32(obj.transitions.length, buffer, bufferOffset);
    obj.transitions.forEach((val) => {
      bufferOffset = Transition.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MachineDescription
    let len;
    let data = new MachineDescription(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [states]
    // Deserialize array length for message field [states]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.states = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.states[i] = State.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [transitions]
    // Deserialize array length for message field [transitions]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.transitions = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.transitions[i] = Transition.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    object.states.forEach((val) => {
      length += State.getMessageSize(val);
    });
    object.transitions.forEach((val) => {
      length += Transition.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/MachineDescription';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0aadf3ce88e651d129124e468424db9d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    State[] states
    Transition[] transitions
    ================================================================================
    MSG: custom_msgs/State
    string name
    string progress
    ================================================================================
    MSG: custom_msgs/Transition
    string name
    State in
    State out
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MachineDescription(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.states !== undefined) {
      resolved.states = new Array(msg.states.length);
      for (let i = 0; i < resolved.states.length; ++i) {
        resolved.states[i] = State.Resolve(msg.states[i]);
      }
    }
    else {
      resolved.states = []
    }

    if (msg.transitions !== undefined) {
      resolved.transitions = new Array(msg.transitions.length);
      for (let i = 0; i < resolved.transitions.length; ++i) {
        resolved.transitions[i] = Transition.Resolve(msg.transitions[i]);
      }
    }
    else {
      resolved.transitions = []
    }

    return resolved;
    }
};

module.exports = MachineDescription;
