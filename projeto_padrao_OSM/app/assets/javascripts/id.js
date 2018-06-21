//= require iD

/* globals iD */

document.addEventListener("DOMContentLoaded", function() {
  var container = document.getElementById("id-container");

  if (typeof iD === 'undefined' || !iD.Detect().support) {
    container.innerHTML = 'This editor is supported ' +
      'in Firefox, Chrome, Safari, Opera, Edge, and Internet Explorer 11. ' +
      'Please upgrade your browser to edit the map.';
    container.className = 'unsupported';
  } else {

    fetch("/aom/json").then( function(response) {return response.json();} ).then(function(j) {
      console.log(iD.data.presets);
      console.log(j);
      let presobj = {};
      let primi = {
        "area": {
          "name": "Area",
          "tags": {},
          "geometry": ["area"]
        },
        "line": {
            "name": "Line",
            "tags": {},
            "geometry": ["line"]
        },
        "point": {
            "name": "Point",
            "tags": {},
            "geometry": ["point"]
        },
        "vertex": {
            "name": "Vertex",
            "tags": {},
            "geometry": ["vertex"]
        },
        "relation": {
            "name": "Relation",
            "tags": {},
            "geometry": ["relation"]
        }
      };
      let atributoObj = iD.data.presets.fields;
      for (let i in atributoObj) {
        atributoObj[i].universal = false;
      }
      for (let i=0; i<j.length; i++) {
        console.log(j[i].nome_tipo);
        let nome = j[i].nome_tipo;
        let tag = {};
        tag[nome] = "*";
        presobj[nome] = {"name": nome, "tags":tag, "geometry": ["point", "area", "line"], "fields":["name"]};
        for (let k=0; k<j[i].atributos.length; k++) {
          let atrib = j[i].atributos[k];
          atributoObj[atrib.nome] = {
            "key": atrib.nome,
            "label": atrib.nome,
            "placeholder": atrib.hint,
            "type": "localized"
          };
          presobj[nome].fields.push(atrib.nome);
        }
      }
/*
      atributoObj["name"] = {
        "key": "name",
        "type": "localized",
        "label": "Name",
        "placeholder": "Nome a inserir"
      };
*/
      for (let i in primi) {
        presobj[i] = primi[i];
      }

      //iD.data.presets = {};
      //iD.data.presets["presets"]= primi; //presobj;
      iD.data.presets = {
        fields: atributoObj,
        presets: presobj
      };
      //iD.data.presets.fields = atributoObj;
      //iD.data.presets.presets = presobj;
      console.log(iD.data.presets);

      var id = iD.Context()
        .minEditableZoom(7)
        .embed(true)
        .assetPath("iD/")
        .assetMap(JSON.parse(container.dataset.assetMap))
        .locale(container.dataset.locale, container.dataset.localePath)
        .preauth({
          urlroot: location.protocol + "//" + location.host,
          oauth_consumer_key: container.dataset.consumerKey,
          oauth_secret: container.dataset.consumerSecret,
          oauth_token: container.dataset.token,
          oauth_token_secret: container.dataset.tokenSecret
        });
      


      id.map().on('move.embed', parent.$.throttle(250, function() {
        if (id.inIntro()) return;
        var zoom = ~~id.map().zoom(),
          center = id.map().center(),
          llz = { lon: center[0], lat: center[1], zoom: zoom };

        parent.updateLinks(llz, zoom);

        // Manually resolve URL to avoid iframe JS context weirdness.
        // http://bl.ocks.org/jfirebaugh/5439412
        var hash = parent.OSM.formatHash(llz);
        if (hash !== parent.location.hash) {
          parent.location.replace(parent.location.href.replace(/(#.*|$)/, hash));
        }
      }));

      parent.$("body").on("click", "a.set_position", function (e) {
        e.preventDefault();
        var data = parent.$(this).data();

        // 0ms timeout to avoid iframe JS context weirdness.
        // http://bl.ocks.org/jfirebaugh/5439412
        setTimeout(function() {
          id.map().centerZoom(
            [data.lon, data.lat],
            Math.max(data.zoom || 15, 13));
        }, 0);
      });

      id.ui()(container);
    });
  }
});
