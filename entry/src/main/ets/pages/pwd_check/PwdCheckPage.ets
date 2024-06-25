
/**
 * 密码验证页面
 */
@Entry
@Component
export struct PwdCheck {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Test()
    }

  }
}

@Component
export struct Test {
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State start: number = 0
  @State end: number = 0

  build() {
    Column() {

      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {

        Circle().width(50).height(50).stroke(Color.Red)

        //在canvas中调用CanvasRenderingContext2D对象。
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .backgroundColor('#F5DC62')
          .onReady(() => {

          })

      }
      .width('100%')
      .height('100%').onTouch((event?: TouchEvent) => {
        if (event) {
          if (event.type === TouchType.Up) {
            // this.eventType = 'Up'
          }
          this.start = event.touches[0].x
          this.end = event.touches[0].y
          this.context.clearRect(0,0,1000,1000)
          // this.context.strokeRect(this.start, this.end, 200, 150);
          this.context.fillRect(this.start-20, this.end-60, 40, 40);
        }
      })
    }
  }
}