/* elm-pkg-js
port text_to_speech : String -> Cmd msg
*/

exports.init = async function (app) {
  app.ports.text_to_speech.subscribe(function (message) {
    const utter = new SpeechSynthesisUtterance(message);
    utter.rate = 0.7;
    window.speechSynthesis.speak(utter);
  });
};
