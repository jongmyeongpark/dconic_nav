
"use strict";

let Transition = require('./Transition.js');
let State = require('./State.js');
let MachineDescription = require('./MachineDescription.js');
let DetectedFaces = require('./DetectedFaces.js');
let FaceInfo = require('./FaceInfo.js');
let NormalizedFaces = require('./NormalizedFaces.js');
let TextCmd = require('./TextCmd.js');
let Zone = require('./Zone.js');
let Obstacles = require('./Obstacles.js');
let Form = require('./Form.js');
let Service = require('./Service.js');
let Dependency = require('./Dependency.js');
let Process = require('./Process.js');
let AppCmd = require('./AppCmd.js');
let Map64 = require('./Map64.js');
let Image64 = require('./Image64.js');
let HeadCmd = require('./HeadCmd.js');
let PhoneCmdVel = require('./PhoneCmdVel.js');
let HeadPose = require('./HeadPose.js');
let BatteryState = require('./BatteryState.js');
let ColorRGB = require('./ColorRGB.js');
let Leds = require('./Leds.js');
let ChargingState = require('./ChargingState.js');
let Mode = require('./Mode.js');
let PlaySong = require('./PlaySong.js');
let Bumper = require('./Bumper.js');
let DefineSong = require('./DefineSong.js');
let MessageRTC = require('./MessageRTC.js');
let Log = require('./Log.js');
let Info = require('./Info.js');
let Heartbeat = require('./Heartbeat.js');
let LedRGBColors = require('./LedRGBColors.js');
let Battery = require('./Battery.js');

module.exports = {
  Transition: Transition,
  State: State,
  MachineDescription: MachineDescription,
  DetectedFaces: DetectedFaces,
  FaceInfo: FaceInfo,
  NormalizedFaces: NormalizedFaces,
  TextCmd: TextCmd,
  Zone: Zone,
  Obstacles: Obstacles,
  Form: Form,
  Service: Service,
  Dependency: Dependency,
  Process: Process,
  AppCmd: AppCmd,
  Map64: Map64,
  Image64: Image64,
  HeadCmd: HeadCmd,
  PhoneCmdVel: PhoneCmdVel,
  HeadPose: HeadPose,
  BatteryState: BatteryState,
  ColorRGB: ColorRGB,
  Leds: Leds,
  ChargingState: ChargingState,
  Mode: Mode,
  PlaySong: PlaySong,
  Bumper: Bumper,
  DefineSong: DefineSong,
  MessageRTC: MessageRTC,
  Log: Log,
  Info: Info,
  Heartbeat: Heartbeat,
  LedRGBColors: LedRGBColors,
  Battery: Battery,
};
