/**
 * 验证 Prop 修饰 Map
 *
 * 结论: 可以监听到 Map 内容变动(值改变, 增删)
 */
@Component
export struct PropDemo {
  // 定义 map, 并进行初始化, 接收一个数组, Map 会自动转化
  @Prop value: Map<number, string> = new Map([[0, "a"], [1, "b"], [3, "c"]])


  build() {
    Column() {
      ForEach(Array.from(this.value.entries()), (item: [number, string]) => {
        Text(`${item[0]}`).fontSize(30)
        Text(`${item[1]}`).fontSize(30)
        Divider()
      })

      // 下面的改动对 Map 监听均生效, 包括对象重置, 新增, 清空, 改变某个值, 删除.
      Button('child init map').onClick(() => {
        this.value = new Map([[0, "a"], [1, "b"], [3, "c"]])
      })
      Button('child set new one').onClick(() => {
        this.value.set(4, "d")
      })
      Button('child clear').onClick(() => {
        this.value.clear()
      })
      Button('child replace the first one').onClick(() => {
        this.value.set(0, "aa")
      })
      Button('child delete the first one').onClick(() => {
        this.value.delete(0)
      })
    }
  }

}