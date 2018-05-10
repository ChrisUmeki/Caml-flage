let authOptions = {
    "domain": "caml-flage.auth0.com",
    "clientID": "NEI3vWpag1sFz5z1IoJV7U52op6HKPxb",
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