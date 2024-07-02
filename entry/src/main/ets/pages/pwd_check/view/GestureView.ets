/**
 * 手势 View
 */
@Component
export struct GestureView {
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State start: number = 0
  @State end: number = 0

  build() {
    Column() {
      // 圆圈背景
      Circles().height('100%').position({ x: 0, y: 0 }).backgroundColor('gray')

      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {

      }
      .width('100%')
      .height('100%').onTouch((event?: TouchEvent) => {
        if (event) {
          if (event.type === TouchType.Up) {
            // this.eventType = 'Up'
          }
          this.start = event.touches[0].x
          this.end = event.touches[0].y
          this.context.clearRect(0, 0, 1000, 1000)
          // this.context.strokeRect(this.start, this.end, 200, 150);
          this.context.fillRect(this.start - 20, this.end - 60, 40, 40);
        }
      })
    }.onAreaChange((oldValue: Area, newValue: Area) => {
      let cw = new Number(newValue.width).valueOf()
      let ch = new Number(newValue.height).valueOf()
      console.log("hepan w = " + cw + "  h = " + ch)
    }).height(360)
  }
}

@Component
struct Circles {

  build() {
    Column() {

      ForEach(["0", "1", "2"], (item: string) => {
        Row() {
          Image($r('app.media.gesture_circle_normal')).height(40).height(40)
          Image($r("app.media.gesture_circle_normal")).height(40).height(40)
          Image($r('app.media.gesture_circle_normal')).height(40).height(40)
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      })
    }

    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .height('100%')
  }
}