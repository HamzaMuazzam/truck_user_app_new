importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
    apiKey: "AIzaSyAL9XvC76KEJgRE_oECAgW1cPfOti3q_TU",
    authDomain: "tucking-app-c9418.firebaseapp.com",
    projectId: "tucking-app-c9418",
    storageBucket: "tucking-app-c9418.appspot.com",
    messagingSenderId: "236880847063",
    appId: "1:236880847063:web:77c7d95af4e2386bf15092",
    measurementId: "G-BELN9KVPQ5",
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});