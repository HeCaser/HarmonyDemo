@Component
export struct GesturePwdSketch {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  @State mWidth: number =60
  // 高亮 pwd
  @Prop @Watch('drawCircles') highlight_pwd: string = ""
  private mItemSpace = 20

  private drawCircles() {

    let cx = this.mWidth / 2
    let cy = cx
    this.context.clearRect(0, 0, this.mWidth, this.mWidth)
    for (let i = 0; i < 9; i++) {
      let row = Math.floor(i / 3)
      let colum = i % 3
      let x: number = colum == 0 ? cx - this.mItemSpace : colum == 1 ? cx : cx + this.mItemSpace
      let y: number = row == 0 ? cy - this.mItemSpace : row == 1 ? cy : cy + this.mItemSpace

      this.context.beginPath()
      this.context.arc(x, y, 4, 0, 6.28)
      if (this.highlight_pwd.indexOf(`${i}`) !== -1) {
        this.context.fillStyle = "#287DFF"
        this.context.fill()
      } else {
        this.context.fillStyle = "#AEB0BB"
        this.context.stroke()
      }
    }
  }

  build() {
    Column() {
      Canvas(this.context)
        .onReady(() => {
          this.drawCircles()
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {

        })
    }.width(this.mWidth)
    .height(this.mWidth)
  }
}
