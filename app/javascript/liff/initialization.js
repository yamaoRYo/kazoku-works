document.addEventListener('DOMContentLoaded', () => {
// CSRFトークンを取得
const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const LIFF_ID = "1661340578-lkX5XQVP";
    liff.init({ 
        liffId: LIFF_ID,
        // ログイン時に外部ブラウザを使用するかの設定
        withLoginOnExternalBrowser: true
    });

    liff.ready.then(() => {
        const idToken = liff.getIdToken();
        const body = `idToken=${idToken}`;
        const request = new Request('/liff', {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
                'X-CSRF-Token': token
            },
            method: 'POST',
            body: body
        });

        // リクエストを送る
        fetch(request)
        // jsonでレスポンスからデータを取得して/after_loginに遷移する
        .then(response => response.json())
        .then(data => {
            data_id = data;
        })
        .then(() => {
            window.location = '/after_login';
        });
    });
});
