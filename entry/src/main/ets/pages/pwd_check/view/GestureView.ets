/**
 * 手势 View
 */
import { Point } from '@ohos.UiTest'
import { ifaa } from '@kit.OnlineAuthenticationKit'

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
  // 手势密码, 若需要从父组件传入,需在画布初始化完成(onCanvasReady)之后设置
  @Prop @Watch('resetLinePath') gesture_pwd: string = ''
  @Prop @Watch('resetLinePath') show_error_pattern?: boolean = false
  @State @Watch('resetLinePath') mTouchPoint?: Point = undefined
  onCanvasReady?: () => void = undefined
  onGestureStart?: () => void = undefined
  onGestureEnd?: (pwd: string) => void = undefined

  private handleTouchEvent(event?: TouchEvent) {
    if (event) {
      if(this.show_error_pattern){
        return
      }
      if (event.type === TouchType.Down) {
        this.onGestureStart?.()
      }
      if (event.type === TouchType.Up) {
        this.mTouchPoint = undefined
        this.onGestureEnd?.(this.gesture_pwd)
      }
      if (event.type == TouchType.Move) {
        if (this.mCircleCenterMap.size > 0) {
          let x = event.touches[0].x
          let y = event.touches[0].y
          this.mTouchPoint = { x, y }
          let index = this.touchPointInCirceIndex({ x, y })
          if (index && this.gesture_pwd.indexOf(index) == -1) {
            this.gesture_pwd = this.gesture_pwd + index
          }
        }
      }
    }
  }

  /**
   * 根据密码重置折线路径
   */
  private resetLinePath() {
    this.mLineContext.clearRect(0, 0, this.mWidth, this.mHeight)
    if (this.gesture_pwd.length < 1) {
      return
    }
    this.mLineContext.beginPath()
    this.mLineContext.lineWidth = 1
    this.mLineContext.strokeStyle = this.show_error_pattern ? 'red' : '#2062e1'
    this.mLineContext.lineJoin = 'round'
    let length = this.gesture_pwd.length
    for (let i = 0; i < length; i++) {
      let char = this.gesture_pwd.charAt(i)
      let point = this.mCircleCenterMap.get(char)
      if (i == 0) {
        this.mLineContext.moveTo(point?.x, point?.y)
      } else {
        this.mLineContext.lineTo(point?.x, point?.y)
      }
    }

    if (this.mTouchPoint) {
      this.mLineContext.lineTo(this.mTouchPoint.x, this.mTouchPoint.y)
    }
    this.mLineContext.stroke()
  }

  /**
   * 当前坐标是否在 Circle 范围以内
   * @returns 0-9 代表在某个 Circle 范围内, 否则不在
   */
  private touchPointInCirceIndex(p: Point): string {
    let radius = this.mCircleWidth / 2

    for (const value of this.numbers) {
      let point = this.mCircleCenterMap.get(value)
      if (point) {
        if (Math.abs(p.x - point.x) < radius && Math.abs(p.y - point.y) < radius) {
          return value
        }
      }
    }
    return ''
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
      Circles({
        itemWidth: this.mCircleWidth,
        pwd: this.gesture_pwd,
        show_error_pattern: this.show_error_pattern
      })
        .height('100%').position({ x: 0, y: 0 })

      Column() {
        Canvas(this.mLineContext).width('100%').height('100%').backgroundColor('translate').onReady(() => {
          setTimeout(() => {
            this.onCanvasReady?.()
          }, 200)
        })

      }.width('100%')
      .height('100%')
      .onTouch((event?: TouchEvent) => {
        this.handleTouchEvent(event)

      }).backgroundColor('translate')

      Text(`--${this.show_error_pattern}`).position({ x: 0, y: 0 })

    }.onAreaChange((oldValue: Area, newValue: Area) => {
      this.handleAreaChange(newValue)
    }).height(this.mHeight)
    .width('100%').backgroundColor('gray')
  }
}

@Component
struct Circles {
  @Prop itemWidth: number = 50
  @Prop pwd: string = ''
  @Prop show_error_pattern?: boolean = false

  private isSelected(index: string) {
    return this.pwd.indexOf(index) != -1
  }

  private getImage() {
    if (this.show_error_pattern) {
      return `app.media.gesture_circle_red`
    }
    return 'app.media.gesture_circle_selected'
  }

  build() {
    Column() {

      ForEach([0, 1, 2], (item: number) => {
        Row() {
          ForEach([0, 1, 2], (child: number) => {
            if (!this.isSelected(`${item * 3 + child}`)) {
              Image($r(`app.media.gesture_circle_normal`)).width(this.itemWidth)
            } else {
              Image($r(`${this.getImage()}`)).width(this.itemWidth)
            }
          })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      })

      // Text(`~~~${this.pwd} ${this.show_error_pattern}`).position({ x: 0, y: 0 })
    }

    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
    .height('100%')
  }
}

