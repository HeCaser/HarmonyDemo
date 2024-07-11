
/**
 * 简易标题栏
 */
@Component
export struct SimpleTitleView {
  @Prop back_icon_src: string = 'app.media.icon_l_close_day'
  @Prop title: string = ""
  @Prop right_title: string = ""
  onRightTitleClick?: () => void = undefined
  onBackClick?: () => void = undefined

  build() {
    RelativeContainer() {

      Image($r(this.back_icon_src))
        .width(60)
        .height(60)
        .onClick(() => {
          this.onBackClick?.()
        })
        .id('back')
        .objectFit(ImageFit.None)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })

      Text(this.title)
        .height("100%")
        .alignRules({
          left: { anchor: 'back', align: HorizontalAlign.End },
          right: { anchor: 'right_title', align: HorizontalAlign.Start }
        })
        .id('title')
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .ellipsisMode(EllipsisMode.END)
        .fontSize(18)


      Text(this.right_title)
        .alignRules({
          right: { anchor: "__container__", align: HorizontalAlign.End },
          top: { anchor: "__container__", align: VerticalAlign.Top }
        })
        .height("100%")
        .width(60)
        .id('right_title')
        .textAlign(TextAlign.Center)
        .fontSize(14)
        .onClick(() => {
          this.onRightTitleClick?.()
        })

    }.height(50)
    .width('100%')
    .backgroundColor('gray')
  }
}