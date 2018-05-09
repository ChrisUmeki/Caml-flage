let authOptions = {
    "domain": "yourdomain.com",
    "clientID": "yourClientID",
    "redirectUri": "http://localhost:3000/callback",
    "responseType": "token id_token",
    "scope": "openid"
  };
  
let authClient = Auth0.createClient(authOptions);



 /* render: self => {
    let onLogin = (_event => authClient##authorize());
    <NavBar
        openLogin=(onLogin)
    />
  } */