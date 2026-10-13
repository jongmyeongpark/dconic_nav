// Auto-generated. Do not edit!

// (in-package landmark.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class VisionCheckResult {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.move_status = null;
      this.ReLocalType = null;
      this.vision_pose = null;
      this.amcl_pose = null;
    }
    else {
      if (initObj.hasOwnProperty('move_status')) {
        this.move_status = initObj.move_status
      }
      else {
        this.move_status = false;
      }
      if (initObj.hasOwnProperty('ReLocalType')) {
        this.ReLocalType = initObj.ReLocalType
      }
      else {
        this.ReLocalType = 0;
      }
      if (initObj.hasOwnProperty('vision_pose')) {
        this.vision_pose = initObj.vision_pose
      }
      else {
        this.vision_pose = new geometry_msgs.msg.PoseWithCovarianceStamped();
      }
      if (initObj.hasOwnProperty('amcl_pose')) {
        this.amcl_pose = initObj.amcl_pose
      }
      else {
        this.amcl_pose = new geometry_msgs.msg.PoseWithCovarianceStamped();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VisionCheckResult
    // Serialize message field [move_status]
    bufferOffset = _serializer.bool(obj.move_status, buffer, bufferOffset);
    // Serialize message field [ReLocalType]
    bufferOffset = _serializer.int8(obj.ReLocalType, buffer, bufferOffset);
    // Serialize message field [vision_pose]
    bufferOffset = geometry_msgs.msg.PoseWithCovarianceStamped.serialize(obj.vision_pose, buffer, bufferOffset);
    // Serialize message field [amcl_pose]
    bufferOffset = geometry_msgs.msg.PoseWithCovarianceStamped.serialize(obj.amcl_pose, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VisionCheckResult
    let len;
    let data = new VisionCheckResult(null);
    // Deserialize message field [move_status]
    data.move_status = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [ReLocalType]
    data.ReLocalType = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [vision_pose]
    data.vision_pose = geometry_msgs.msg.PoseWithCovarianceStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [amcl_pose]
    data.amcl_pose = geometry_msgs.msg.PoseWithCovarianceStamped.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += geometry_msgs.msg.PoseWithCovarianceStamped.getMessageSize(object.vision_pose);
    length += geometry_msgs.msg.PoseWithCovarianceStamped.getMessageSize(object.amcl_pose);
    return length + 2;
  }

  static datatype() {
    // Returns string type for a message object
    return 'landmark/VisionCheckResult';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e74925df1339381ec7aba8760cec83b1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool move_status
    int8 ReLocalType
    geometry_msgs/PoseWithCovarianceStamped vision_pose
    geometry_msgs/PoseWithCovarianceStamped amcl_pose
    ================================================================================
    MSG: geometry_msgs/PoseWithCovarianceStamped
    # This expresses an estimated pose with a reference coordinate frame and timestamp
    
    Header header
    PoseWithCovariance pose
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: geometry_msgs/PoseWithCovariance
    # This represents a pose in free space with uncertainty.
    
    Pose pose
    
    # Row-major representation of the 6x6 covariance matrix
    # The orientation parameters use a fixed-axis representation.
    # In order, the parameters are:
    # (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
    float64[36] covariance
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new VisionCheckResult(null);
    if (msg.move_status !== undefined) {
      resolved.move_status = msg.move_status;
    }
    else {
      resolved.move_status = false
    }

    if (msg.ReLocalType !== undefined) {
      resolved.ReLocalType = msg.ReLocalType;
    }
    else {
      resolved.ReLocalType = 0
    }

    if (msg.vision_pose !== undefined) {
      resolved.vision_pose = geometry_msgs.msg.PoseWithCovarianceStamped.Resolve(msg.vision_pose)
    }
    else {
      resolved.vision_pose = new geometry_msgs.msg.PoseWithCovarianceStamped()
    }

    if (msg.amcl_pose !== undefined) {
      resolved.amcl_pose = geometry_msgs.msg.PoseWithCovarianceStamped.Resolve(msg.amcl_pose)
    }
    else {
      resolved.amcl_pose = new geometry_msgs.msg.PoseWithCovarianceStamped()
    }

    return resolved;
    }
};

module.exports = VisionCheckResult;
