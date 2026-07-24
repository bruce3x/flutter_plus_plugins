/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  FlutterPlugin,
  FlutterPluginBinding
} from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';
import MethodChannel, {
  MethodCallHandler,
  MethodResult
} from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import MethodCall from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodCall';
import EventChannel, { StreamHandler, EventSink } from '@ohos/flutter_ohos/src/main/ets/plugin/common/EventChannel';
import { BinaryMessenger } from '@ohos/flutter_ohos';
import sensor from '@ohos.sensor';
import { BusinessError } from '@kit.BasicServicesKit';
import systemDateTime from '@ohos.systemDateTime';

class StreamHandlerImpl implements StreamHandler {
  private event: EventSink | null = null;
  private sensorId?: sensor.SensorId;
  private currentInterval: number = 200000000;

  constructor(sensorId: sensor.SensorId) {
    this.sensorId = sensorId;
  }

  private initSensorData(interval: number): void {
    switch (this.sensorId) {
      case sensor.SensorId.LINEAR_ACCELEROMETER:
        this.listenLinearAccelerometer(interval);
        break;
      case sensor.SensorId.ACCELEROMETER:
        this.listenAccelerometer(interval);
        break;
      case sensor.SensorId.GYROSCOPE:
        this.listenGyroscope(interval);
        break;
      case sensor.SensorId.MAGNETIC_FIELD:
        this.listenMagnetic(interval);
        break;
      case sensor.SensorId.BAROMETER:
        this.listenBarometer(interval);
        break;
    }
  }

  // user加速度计传感器
  private listenLinearAccelerometer(interval: number): void {
    try {
      if(this.currentInterval !== interval){
        sensor.off(sensor.SensorId.LINEAR_ACCELEROMETER);
        this.currentInterval = interval;
      }
      let timestampMicroAtBoot = (systemDateTime.getTime(true) / 1000) - (systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000);
      sensor.on(sensor.SensorId.LINEAR_ACCELEROMETER, (data: sensor.LinearAccelerometerResponse) => {
        if (this.event) {
          let arr: Array<number> = [4];
          let timestampMicro = (timestampMicroAtBoot + (data.timestamp * 1000)) / 1000000;
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          arr[3] = timestampMicro;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          if (Number.isInteger(timestampMicro)) {
            arr[3] = timestampMicro + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: interval });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 加速度计传感器
  private listenAccelerometer(interval: number): void {
    try {
      if(this.currentInterval !== interval){
        sensor.off(sensor.SensorId.ACCELEROMETER);
        this.currentInterval = interval;
      }
      let timestampMicroAtBoot = (systemDateTime.getTime(true) / 1000) - systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000;
      sensor.on(sensor.SensorId.ACCELEROMETER, (data: sensor.AccelerometerResponse) => {
        if (this.event) {
          let arr: Array<number> = [4];
          let timestampMicro = (timestampMicroAtBoot + (data.timestamp * 1000)) / 1000000;
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          arr[3] = timestampMicro;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          if (Number.isInteger(timestampMicro)) {
            arr[3] = timestampMicro + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: interval });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 陀螺仪传感器
  private listenGyroscope(interval: number): void {
    try {
      if(this.currentInterval !== interval){
        sensor.off(sensor.SensorId.GYROSCOPE);
        this.currentInterval = interval;
      }
      let timestampMicroAtBoot = (systemDateTime.getTime(true) / 1000) - systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000;
      sensor.on(sensor.SensorId.GYROSCOPE, (data: sensor.GyroscopeResponse) => {
        let timestampMicro = (timestampMicroAtBoot + (data.timestamp * 1000)) / 1000000;
        if (this.event) {
          let arr: Array<number> = [4];
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          arr[3] = timestampMicro;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          if (Number.isInteger(timestampMicro)) {
            arr[3] = timestampMicro + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: interval });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 磁力计传感器
  private listenMagnetic(interval: number): void {
    try {
      if(this.currentInterval !== interval){
        sensor.off(sensor.SensorId.MAGNETIC_FIELD);
        this.currentInterval = interval;
      }
      let timestampMicroAtBoot = (systemDateTime.getTime(true) / 1000) - systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000;
      sensor.on(sensor.SensorId.MAGNETIC_FIELD, (data: sensor.MagneticFieldResponse) => {
        if (this.event) {
          let arr: Array<number> = [4];
          let timestampMicro = (timestampMicroAtBoot + (data.timestamp * 1000)) / 1000000;
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          arr[3] = timestampMicro;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          if (Number.isInteger(timestampMicro)) {
            arr[3] = timestampMicro + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: interval });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 气压传感器
  private listenBarometer(interval: number): void {
    try {
      if(this.currentInterval !== interval){
        sensor.off(sensor.SensorId.BAROMETER);
        this.currentInterval = interval;
      }
      let timestampMicroAtBoot = (systemDateTime.getTime(true) / 1000) - systemDateTime.getUptime(systemDateTime.TimeType.ACTIVE, true) / 1000;
      sensor.on(sensor.SensorId.BAROMETER, (data: sensor.BarometerResponse) => {
        if (this.event) {
          let arr: Array<number> = [2];
          let timestampMicro = (timestampMicroAtBoot + (data.timestamp * 1000)) / 1000000;
          arr[0] = data.pressure;
          arr[1] = timestampMicro;
          if (Number.isInteger(data.pressure)) {
            arr[0] = data.pressure + 0.00000000001;
          }
          if (Number.isInteger(timestampMicro)) {
            arr[1] = timestampMicro + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: interval });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  setUpdateInterval(interval: number) {
    let mapped: number = 0;
    switch (interval) {
      case 20000:
        mapped = 20000000;
        break;
      case 66667 :
        mapped = 66667000;
        break;
      case 200000:
        mapped = 200000000;
        break;
      case 500000:
        mapped = 500000000;
        break;
      case 1000000:
        mapped = 1000000000;
        break;
    }
    if (mapped === 0) {
      return;
    }
    // 无订阅时只记录采样间隔,待 onListen 时生效;有订阅时立即按新间隔重新注册。
    if (this.event != null) {
      this.initSensorData(mapped);
    } else {
      this.currentInterval = mapped;
    }
  }

  // 隐私合规: 仅在 Dart 侧订阅时注册系统传感器,取消订阅立即注销,
  // 避免应用启动即采集与后台占用传感器。
  onListen(args: ESObject, events: EventSink): void {
    this.event = events;
    this.initSensorData(this.currentInterval);
  }

  onCancel(args: ESObject): void {
    this.event = null;
    this.stopSensor();
  }

  private stopSensor(): void {
    // sensor.off 按具体 SensorId 字面量重载, 不能传泛型变量, 需逐个分发。
    try {
      switch (this.sensorId) {
        case sensor.SensorId.LINEAR_ACCELEROMETER:
          sensor.off(sensor.SensorId.LINEAR_ACCELEROMETER);
          break;
        case sensor.SensorId.ACCELEROMETER:
          sensor.off(sensor.SensorId.ACCELEROMETER);
          break;
        case sensor.SensorId.GYROSCOPE:
          sensor.off(sensor.SensorId.GYROSCOPE);
          break;
        case sensor.SensorId.MAGNETIC_FIELD:
          sensor.off(sensor.SensorId.MAGNETIC_FIELD);
          break;
        case sensor.SensorId.BAROMETER:
          sensor.off(sensor.SensorId.BAROMETER);
          break;
      }
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke off. Code: ${e.code}, message: ${e.message}`);
    }
  }
}

/** SensorsPlusOhosPlugin **/
export default class SensorsPlusOhosPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  private ACCELEROMETER_CHANNEL_NAME = 'dev.fluttercommunity.plus/sensors/accelerometer';
  private USER_ACCELEROMETER_CHANNEL_NAME = 'dev.fluttercommunity.plus/sensors/user_accel';
  private GYROSCOPE_CHANNEL_NAME = 'dev.fluttercommunity.plus/sensors/gyroscope';
  private MAGNETOMETER_CHANNEL_NAME = 'dev.fluttercommunity.plus/sensors/magnetometer';
  private BAROMETER_CHANNEL_NAME = 'dev.fluttercommunity.plus/sensors/barometer';

  private accelerometerChannel: EventChannel | null = null;
  private gyroscopeChannel: EventChannel | null = null;
  private magnetometerChannel: EventChannel | null = null;
  private userAccelerometerChannel: EventChannel | null = null;
  private barometerChannel: EventChannel | null = null;

  private accelerationStreamHandler: StreamHandlerImpl | null = null;
  private gyroScopeStreamHandler: StreamHandlerImpl | null = null;
  private magnetometerStreamHandler: StreamHandlerImpl | null = null;
  private userAccelerationStreamHandler: StreamHandlerImpl | null = null;
  private barometerStreamHandler: StreamHandlerImpl | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "SensorsPlusOhosPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "dev.fluttercommunity.plus/sensors/method");
    this.channel.setMethodCallHandler(this)
    this.setupEventChannels(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
    // 引擎销毁时注销所有可能仍在监听的传感器。
    this.accelerationStreamHandler?.onCancel(null);
    this.gyroScopeStreamHandler?.onCancel(null);
    this.magnetometerStreamHandler?.onCancel(null);
    this.userAccelerationStreamHandler?.onCancel(null);
    this.barometerStreamHandler?.onCancel(null);
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    switch (call.method) {
      case 'setAccelerationSamplingPeriod':
        this.accelerationStreamHandler?.setUpdateInterval(call.args as number);
        break;
      case 'setGyroscopeSamplingPeriod':
        this.gyroScopeStreamHandler?.setUpdateInterval(call.args as number);
        break;
      case 'setUserAccelerometerSamplingPeriod':
        this.userAccelerationStreamHandler?.setUpdateInterval(call.args as number);
        break;
      case 'setMagnetometerSamplingPeriod':
        this.magnetometerStreamHandler?.setUpdateInterval(call.args as number);
        break;
      case 'setBarometerSamplingPeriod':
        this.barometerStreamHandler?.setUpdateInterval(call.args as number);
        break;
      default:
        result.notImplemented();
    }
  }

  private setupEventChannels(context: Context, messenger: BinaryMessenger) {
    // user加速度计
    this.userAccelerometerChannel = new EventChannel(messenger, this.USER_ACCELEROMETER_CHANNEL_NAME);
    this.userAccelerationStreamHandler = new StreamHandlerImpl(sensor.SensorId.LINEAR_ACCELEROMETER);
    this.userAccelerometerChannel.setStreamHandler(this.userAccelerationStreamHandler);

    // 加速度计
    this.accelerometerChannel = new EventChannel(messenger, this.ACCELEROMETER_CHANNEL_NAME);
    this.accelerationStreamHandler = new StreamHandlerImpl(sensor.SensorId.ACCELEROMETER);
    this.accelerometerChannel.setStreamHandler(this.accelerationStreamHandler);

    // 磁力计
    this.magnetometerChannel = new EventChannel(messenger, this.MAGNETOMETER_CHANNEL_NAME);
    this.magnetometerStreamHandler = new StreamHandlerImpl(sensor.SensorId.MAGNETIC_FIELD);
    this.magnetometerChannel.setStreamHandler(this.magnetometerStreamHandler);

    // 陀螺仪
    this.gyroscopeChannel = new EventChannel(messenger, this.GYROSCOPE_CHANNEL_NAME);
    this.gyroScopeStreamHandler = new StreamHandlerImpl(sensor.SensorId.GYROSCOPE);
    this.gyroscopeChannel.setStreamHandler(this.gyroScopeStreamHandler);

    // 气压计
    this.barometerChannel = new EventChannel(messenger, this.BAROMETER_CHANNEL_NAME);
    this.barometerStreamHandler = new StreamHandlerImpl(sensor.SensorId.BAROMETER);
    this.barometerChannel.setStreamHandler(this.barometerStreamHandler);
  }
}
