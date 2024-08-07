import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { DbUtil } from '../pages/util/DbUtil';


const APP_SESSION_CONTINUE_MILLIS: number = 1 * 60 * 1000

function getMills() {
  return new Date().getTime()
}
export default class EntryAbility extends UIAbility {
  mInBackgroundTimePoint = 0

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    DbUtil.init(this.context)
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // console.log("hepan 前台了")
    let current = getMills()
    if (current - this.mInBackgroundTimePoint > APP_SESSION_CONTINUE_MILLIS) {
      this.executedTasksWhenAppInForeground()
    }
  }

  onBackground(): void {
    this.mInBackgroundTimePoint = getMills()
  }

  /**
   * 首次启动 & app 回到前台调用此方法
   * 逻辑参见雪球工程 com.xueqiu.android.base.AppEngine 类
   */
  executedTasksWhenAppInForeground() {
    // console.log("hepan 前后台切换触发")
  }
}
