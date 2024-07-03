/**
 * 手势 View
 */
import { Point } from '@ohos.UiTest'

@Component
export struct GestureView {
  // 代表九个点, 从左到右, 从上到下
  private numbers: string[] = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  private mHeight: number = 320
  private mWidth: number = -1
  private mCircleWidth = 50
  // 圆圈中心点
  private mCircleCenterMap: Map<string, Point> = new Map()
  // 绘制线段上下文
  private mLineContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private handleTouchEvent(event?: TouchEvent) {
    if (event) {
      if (event) {
        if (event.type === TouchType.Up) {
          // this.eventType = 'Up'
        }
        if (event.type == TouchType.Move) {
          if (this.mCircleCenterMap.size > 0) {
            let x = event.touches[0].x
            let y = event.touches[0].y

            this.mLineContext.clearRect(0, 0, this.mWidth, this.mHeight)

            this.mLineContext.beginPath()
            this.mLineContext.lineWidth = 1
            this.mLineContext.lineJoin = 'round'
            this.getCircleAreaIndex({ x, y })
            /* this.numbers.map((item: string) => {
               let point = this.mCircleCenterMap.get(item)
               if (item == '0') {
                 this.mLineContext.moveTo(point?.x, point?.y)
               } else {
                 this.mLineContext.lineTo(point?.x, point?.y)
               }
             })
             this.mLineContext.stroke()*/
          }
        }
      }
    }
  }

  /**
   * 当前坐标是否在 Circle 范围以内
   * @returns 0-9 代表在某个 Circle 范围内, 否则不在
   */
  private getCircleAreaIndex(p: Point): string {
    let index = ''
    let radius = this.mCircleWidth / 2
    this.numbers.forEach((value: string) => {
      let point = this.mCircleCenterMap.get(value)
      if (point) {
        if (Math.abs(p.x - point.x) < radius && Math.abs(p.y - point.y) < radius) {
          console.log(`hepan 处在 ${value} 范围内`)
        }
      }
    })
    return index

  }

  private handleAreaChange(newArea: Area) {
    let cw = new Number(newArea.width).valueOf()
    this.mWidth = cw

    // 计算九个圆圈的中心点
    let spaceX = (this.mWidth - 3 * this.mCircleWidth) / 4 // 采用 SpaceEvenly 分配 View 的间距
    let spaceY = (this.mHeight - 3 * this.mCircleWidth) / 4
    let itemSpaceX = spaceX + this.mCircleWidth
    let itemSpaceY = spaceY + this.mCircleWidth
    let cx = this.mWidth / 2
    let cy = this.mHeight / 2

    this.mCircleCenterMap.clear()
    this.numbers.map((value: string, index: number) => {
      let row = Math.floor(index / 3)
      let colum = index % 3
      let x: number = colum == 0 ? cx - itemSpaceX : colum == 1 ? cx : cx + itemSpaceX
      let y: number = row == 0 ? cy - itemSpaceY : row == 1 ? cy : cy + itemSpaceY
      this.mCircleCenterMap.set(value, { x, y })
      // console.log(`hepan index = ${index} 中心 = [${x}:${y}]`)
    })

  }

  build() {
    Column() {
      // 圆圈背景
      Circles({ itemWidth: this.mCircleWidth }).height('100%').position({ x: 0, y: 0 })
      Column() {
        Canvas(this.mLineContext).width('100%').height('100%').backgroundColor('translate')

      }.width('100%')
      .height('100%')
      .onTouch((event?: TouchEvent) => {
        this.handleTouchEvent(event)

      }).backgroundColor('translate')

    }.onAreaChange((oldValue: Area, newValue: Area) => {
      this.handleAreaChange(newValue)
    }).height(this.mHeight)
    .width('100%').backgroundColor('gray')
  }
}

@Component
struct Circles {
  @Prop itemWidth: number = 50

  build() {
    Column() {

      ForEach(["0", "1", "2"], (item: string) => {
        Row() {
          // fix: 切换图片背景时, 位置闪动: 图片大小不一致, 外面包裹一层固定宽高的 View
          Row() {
            Image($r('app.media.gesture_circle_normal')).height(40).height(40).border({ width: 2, color: Color.Pink })
          }.height(this.itemWidth).width(this.itemWidth).justifyContent(FlexAlign.Center).backgroundColor('#fdd')

          Row() {
            Image($r('app.media.gesture_circle_selected')).height(50).height(50).border({ width: 2, color: Color.Pink })
          }.height(this.itemWidth).width(this.itemWidth).justifyContent(FlexAlign.Center)

          Row() {
            Image($r('app.media.gesture_circle_red')).height(50).height(50).border({ width: 2, color: Color.Pink })
          }.height(this.itemWidth).width(this.itemWidth).justifyContent(FlexAlign.Center)

        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      })
    }

    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .height('100%')
  }
}