/**
 * 手势 View
 */
@Component
export struct GestureView {
  @State mHeight: number = 320
  private mWidth: number = -1
  // 绘制线段上下文
  private mLineContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  @State start: number = 0
  @State end: number = 0

  private handleTouchEvent(event?: TouchEvent) {
    if (event) {
      if (event) {
        if (event.type === TouchType.Up) {
          // this.eventType = 'Up'
        }
        if (event.type == TouchType.Move) {

        }
        this.start = event.touches[0].x
        this.end = event.touches[0].y
        this.mLineContext.clearRect(0, 0, this.mWidth, this.mHeight)
        // // this.context.strokeRect(this.start, this.end, 200, 150);
        // this.mLineContext.fillRect(this.start, this.end, 40, 40);

        this.mLineContext.beginPath()
        this.mLineContext.lineWidth = 1
        this.mLineContext.lineJoin = 'miter'
        this.mLineContext.moveTo(30, 30)
        this.mLineContext.lineTo( this.start, this.end)
        this.mLineContext.stroke()
      }
    }

  }

  build() {
    Column() {
      // 圆圈背景
      Circles().height('100%').position({ x: 0, y: 0 }).backgroundColor('gray')

      Column() {
        Canvas(this.mLineContext).width('100%').height('100%')

      }.width('100%')
      .height('100%')
      .onTouch((event?: TouchEvent) => {
        this.handleTouchEvent(event)

      })

    }.onAreaChange((oldValue: Area, newValue: Area) => {
      let cw = new Number(newValue.width).valueOf()
      this.mWidth = cw
    }).height(this.mHeight)
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