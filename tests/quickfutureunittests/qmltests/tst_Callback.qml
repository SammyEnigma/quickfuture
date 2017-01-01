import QtQuick 2.0
import QtTest 1.1
import Testable 1.0
import Future 1.0
import FutureTests 1.0

TestCase {

    name: "CallbackTests";

    function test_onFinished() {
        var called = false;
        var result;
        var future = Actor.read("a-file-not-existed");

        Future.onFinished(future, function(value) {
            called = true;
            result = value;
        });
        compare(called, false);
        wait(1000);
        compare(called, true);
        compare(result, "");
    }

    function test_onFinished_void() {
        var called = false;
        var result;

        var future = Actor.dummy();

        compare(Future.isFinished(future), false);
        compare(Future.isRunning(future), true);

        Future.onFinished(future, function(value) {
            called = true;
            result = value;
        });
        wait(1000);
        compare(called, true);
        compare(result, undefined);
        compare(Future.isRunning(future), false);
    }

    function test_alreadyFinished() {
        var called = false;

        var future = Actor.alreadyFinished();
        compare(Future.isFinished(future), true);
        Future.onFinished(future, function(value) {
            called = true;
        });
        compare(called, false);
        wait(10);
        compare(called, true);
    }


}