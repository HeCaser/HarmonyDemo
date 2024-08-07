import { emitter } from '@kit.BasicServicesKit'

/**
 * 测试鸿蒙总线事件
 * 1. 在雪基开发中遇到一个问题: 游客页和Bridge同时注册登录成功事件, 但是只有一个可以接收到
 */
@Entry
@Component
struct EmitterEvent {
  aboutToAppear(): void {
    this.emitterTwice()
    // console.log("hepan EmitterEvent 首页可见")
  }

  aboutToDisappear(): void {
    this.cancelTwice()
    // console.log("hepan EmitterEvent 消失")
  }

  build() {
    Column() {
      Text("我是事件监听页面")
      Button("点击发送事件 10").onClick(() => {
        emitter.emit({ eventId: 10 })
      })
      Button("点击取消事件 10").onClick(() => {
        emitter.off(10)
      })
    }

  }

  /**
   * 测试监听同一个事件两次
   * 1. emitter.on 会一直监听事件的发生
   * 2. emitter.once 只触发一次, 触发后对于的监听数 emitter.getListenerCount 减 1
   */
  private emitterTwice() {

    emitter.on({
      eventId: 10
    }, () => {
      console.log("hepan 接收 2")
    })

    emitter.once({
      eventId: 10
    }, () => {
      console.log("hepan 接收 1")
    })
  }

  /**
   * 结论: emitter.off 会取消所有监听
   */
  private cancelTwice() {
    let count = emitter.getListenerCount(10)
    console.log("hepan 原有数量 " + count)
    emitter.off(10)
    let count1 = emitter.getListenerCount(10)
    console.log("hepan 取消监听后数量 " + count1)
  }
}