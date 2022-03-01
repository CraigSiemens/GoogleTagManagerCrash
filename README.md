# GoogleTagManagerCrash

This repo is a sample project showing off a crash that occurs in GoogleTagManager when used with Firebase and GoogleMaps. 

## Filed Issues

- https://github.com/firebase/firebase-ios-sdk/issues/9235
- https://support.google.com/tagmanager/thread/139687964?hl=en
- https://support.google.com/tagmanager/thread/146683947?hl=en
- https://issuetracker.google.com/issues/209843433

## Setup

### Firebase
Add the `GoogleService-Info.plist` file to the project
https://firebase.google.com/docs/ios/setup#add-config-file

### GoogleTagManger
Add your contains to the project. Steps 2-4 in the link below.
https://developers.google.com/tag-platform/tag-manager/ios/v5#1_add_tag_manager_to_your_project

### GoogleMaps
Add your GoogleMaps API key into `GoogleService-Info.plist` with the key `GOOGLE_MAPS_API_KEY`.
https://developers.google.com/maps/documentation/ios-sdk/config#install-the-xcframework

## Crash Details

The app will always crash on a simulator running on an M1 Mac and occasionally crash on a device.

Google tag manager crashes when handling the screen_view events (found by printing out registers in `-[TAGRuntime evaluateEvent:]`).

- Turning off `screen_view` events fixes the issue.
- The issue doesn't occur with any other analytics event.
- Removing the map fixes the issue (but not an option)
- Removing google tag manager fixes the issue (but not an option)
- Running Xcode using Rosetta fixes the issue, but the dependencies being XCFrameworks is supposed to remove the need for that.

### Versions
Firebase - 8.12.1
GoogleTagManager - 7.4.0
GoogleMaps - 6.0.1-beta

### Stack Trace

```
Thread 29 Queue : TagManagerContainerQueue (serial)
#0    0x00000002a00047c0 in 0x2a00047c0 ()
#1    0x0000000124a8698c in JSC::Interpreter::executeCall(JSC::JSGlobalObject*, JSC::JSObject*, JSC::CallData const&, JSC::JSValue, JSC::ArgList const&) ()
#2    0x0000000124cb1154 in JSC::profiledCall(JSC::JSGlobalObject*, JSC::ProfilingReason, JSC::JSValue, JSC::CallData const&, JSC::JSValue, JSC::ArgList const&) ()
#3    0x00000001244a179c in JSObjectCallAsFunction ()
#4    0x000000012442cc10 in -[JSValue invokeMethod:withArguments:] ()
#5    0x00000001075b9d00 in -[TAGRuntime evaluateEvent:] ()
#6    0x00000001075ac878 in __29-[TAGContainer processEvent:]_block_invoke ()
#7    0x000000011119fe94 in _dispatch_call_block_and_release ()
#8    0x00000001111a1694 in _dispatch_client_callout ()
#9    0x00000001111a8870 in _dispatch_lane_serial_drain ()
#10    0x00000001111a9534 in _dispatch_lane_invoke ()
#11    0x00000001111b5664 in _dispatch_workloop_worker_thread ()
#12    0x00000001c99caad4 in _pthread_wqthread ()
Enqueued from TagManagerQueue (Thread 29) Queue : TagManagerQueue (serial)
#0    0x00000001111a5a60 in dispatch_async ()
#1    0x00000001075ac718 in -[TAGContainer processEvent:] ()
#2    0x00000001075b875c in __39-[TAGManager maybeLoadDefaultContainer]_block_invoke_2.311 ()
#3    0x000000011119fe94 in _dispatch_call_block_and_release ()
#4    0x00000001111a1694 in _dispatch_client_callout ()
#5    0x00000001111a8870 in _dispatch_lane_serial_drain ()
#6    0x00000001111a9534 in _dispatch_lane_invoke ()
#7    0x00000001111b5664 in _dispatch_workloop_worker_thread ()
#8    0x00000001c99caad4 in _pthread_wqthread ()
#9    0x00000001c99c988c in start_wqthread ()
Enqueued from APMAnalyticsQueue (Thread 29) Queue : APMAnalyticsQueue (serial)
#0    0x00000001111a5a60 in dispatch_async ()
#1    0x00000001075b860c in __39-[TAGManager maybeLoadDefaultContainer]_block_invoke.300 ()
#2    0x00000001074bfef0 in +[APMAnalytics notifyEventListenersOnSerialQueue:] ()
#3    0x000000011119fe94 in _dispatch_call_block_and_release ()
#4    0x00000001111a1694 in _dispatch_client_callout ()
#5    0x00000001111a8870 in _dispatch_lane_serial_drain ()
#6    0x00000001111a9534 in _dispatch_lane_invoke ()
#7    0x00000001111b5664 in _dispatch_workloop_worker_thread ()
#8    0x00000001c99caad4 in _pthread_wqthread ()
#9    0x00000001c99c988c in start_wqthread ()
Enqueued from  (Thread 29) Queue :  (serial)
#0    0x00000001111a5a60 in dispatch_async ()
#1    0x00000001074bc2e0 in +[APMAnalytics dispatchAsyncOnSerialQueue:] ()
#2    0x00000001109dbc6c in __NSBLOCKOPERATION_IS_CALLING_OUT_TO_A_BLOCK__ ()
#3    0x00000001109dbb48 in -[NSBlockOperation main] ()
#4    0x00000001109dec94 in __NSOPERATION_IS_INVOKING_MAIN__ ()
#5    0x00000001109dac20 in -[NSOperation start] ()
#6    0x00000001109df63c in __NSOPERATIONQUEUE_IS_STARTING_AN_OPERATION__ ()
#7    0x00000001109df13c in __NSOQSchedule_f ()
#8    0x00000001111b0b54 in _dispatch_block_async_invoke2 ()
#9    0x00000001111a1694 in _dispatch_client_callout ()
#10    0x00000001111a43e0 in _dispatch_continuation_pop ()
#11    0x00000001111a3834 in _dispatch_async_redirect_invoke ()
#12    0x00000001111b3c04 in _dispatch_root_queue_drain ()
#13    0x00000001111b46fc in _dispatch_worker_thread2 ()
#14    0x00000001c99caa98 in _pthread_wqthread ()
#15    0x00000001c99c988c in start_wqthread ()
Enqueued from com.google.fira.worker (Thread 19) Queue : com.google.fira.worker (serial)
#0    0x00000001111a5a60 in dispatch_async ()
#1    0x00000001109d8d94 in __NSOQSchedule ()
#2    0x00000001109dcbe4 in __addOperations ()
#3    0x00000001074bc370 in +[APMAnalytics queueOperationWithBlock:] ()
#4    0x00000001074bfde8 in +[APMAnalytics notifyEventListeners:] ()
#5    0x000000010750ed2c in -[APMMeasurement logEventOnWorkerQueue:notifyEventListeners:] ()
#6    0x000000010750ec9c in -[APMMeasurement logEventOnWorkerQueueWithOrigin:isPublicEvent:name:parameters:timestamp:enabled:ignoreEnabled:ignoreInterceptor:interceptor:addedScreenParameters:] ()
#7    0x000000010750e978 in __151-[APMMeasurement logEventWithOrigin:isPublicEvent:name:parameters:timestamp:enabled:ignoreEnabled:ignoreInterceptor:interceptor:addedScreenParameters:]_block_invoke ()
#8    0x00000001075541a8 in __51-[APMScheduler scheduleOnWorkerQueueBlockID:block:]_block_invoke ()
#9    0x000000011119fe94 in _dispatch_call_block_and_release ()
#10    0x00000001111a1694 in _dispatch_client_callout ()
#11    0x00000001111a8870 in _dispatch_lane_serial_drain ()
#12    0x00000001111a9534 in _dispatch_lane_invoke ()
#13    0x00000001111b5664 in _dispatch_workloop_worker_thread ()
#14    0x00000001c99caad4 in _pthread_wqthread ()
#15    0x00000001c99c988c in start_wqthread ()
```
