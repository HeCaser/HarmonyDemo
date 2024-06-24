import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

/**
 * App 前后台切换触发阈值
 * 整理逻辑参见雪球工程中 com.xueqiu.android.base.AppEngine 类
 */
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
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    console.log("hepan 前台了")
    let current = getMills()
    if (current - this.mInBackgroundTimePoint > APP_SESSION_CONTINUE_MILLIS) {
      this.executedTasksWhenAppInForeground()
    }
  }

  onBackground(): void {
    this.mInBackgroundTimePoint = getMills()
  }

  executedTasksWhenAppInForeground() {
    AlertDialog.show({message:'触发'})
    console.log("hepan 触发")
  }
}
