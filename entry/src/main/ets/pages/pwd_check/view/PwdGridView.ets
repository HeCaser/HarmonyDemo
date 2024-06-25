@Component
export struct PwdGridView {
  @Prop pwd: string = ''

  build() {
    Row() {
      Item({ value: this.pwd.charAt(0), index: 0 })
      Item({ value: this.pwd.charAt(1), index: 1 })
      Item({ value: this.pwd.charAt(2), index: 2 })
      Item({ value: this.pwd.charAt(3), index: 3 })
      Item({ value: this.pwd.charAt(4), index: 4 })

    }.width('100%').height('100%').justifyContent(FlexAlign.SpaceAround)
  }
}

@Component
struct Item {

  value: string = ''
  index: number = 0

  lastIndex: number = 4
  borderW: number = 1

  build() {
    Text(this.value)
      .layoutWeight(1)
      .textAlign(TextAlign.Center)
      .height('100%')
      .borderWidth({
        top: this.borderW,
        bottom: this.borderW,
        right: this.index == this.lastIndex ? this.borderW : 0,
        left: this.borderW
      })
      .borderColor('#ddd')
  }
}