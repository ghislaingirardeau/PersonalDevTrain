/* FUNCTION COLORS LEAVES ON MOUNTED */

export function emotionsColor (emotion) {
    let index = 0 /* envoie l'index a l'objet */
    const object = document.getElementsByClassName(`Vector`)
    let fear = ['scared', 'terrifier', 'insecure', 'nervous', 'horrfied']
    /* Ajout une class appear a chaque index tant que index est inferieur au nombre d'emotions */
        
    do {
        object[index].classList.add("appear")
        object[index].style.animationDelay = `${index * 0.2}s`;
        /* envoie une couleur suivant emotion negative */
        
        switch (emotion[index]) {
            /*colors HSV: primary 98%, 82% \ secondary 69%, 87% \ third 39%, 92%*/
            case 'fear' : object[index].setAttribute('fill', '#d11c04') /* red  */
            break;
            case 'scared':
            case 'terrifier':    
            case 'insecure':
            case 'nervous':
            case 'horrfied': object[index].setAttribute('fill', '#de5745')
            break;
            case 'anger': object[index].setAttribute('fill', '#d17c04') /* orange */
            break;
            case 'disgusted':
            case 'enraged':    
            case 'irritable':
            case 'exasperated':
            case 'jealous': object[index].setAttribute('fill', '#de9e45')
            break;
            case 'sadness': object[index].setAttribute('fill', '#d1bd04') /* yellow */
            break;
            case 'hurt':
            case 'unhappy':    
            case 'disappointed':
            case 'shameful':
            case 'gloomy':
            case 'lonely': object[index].setAttribute('fill', '#d1c341') 
            break;
            case 'surprise': object[index].setAttribute('fill', '#0408d1') /* blue */
            break;  
            case 'confused':
            case 'overcome':    
            case 'stunned':
            case 'amazed':
            case 'moved': object[index].setAttribute('fill', '#4548de') 
            break;
            case 'joy': object[index].setAttribute('fill', '#37d104') /* green */
            break;
            case 'euphoric':
            case 'excited':    
            case 'optimistic':
            case 'proud':
            case 'cheerful':    
            case 'peaceful':
            case 'content':
            case 'happy': object[index].setAttribute('fill', '#6bde45')
            break;
            case 'love': object[index].setAttribute('fill', '#04d1c3') /* turquoise */
            break;
            case 'sentimental':
            case 'affectionate':    
            case 'romantic':
            case 'enchanted':
            case 'grateful': object[index].setAttribute('fill', '#45ded4') 
        }
        
        index++
    } while(index < (emotion.length))
}

/* FUNCTION UPPERCASE USER NAME  */

export function upperFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1) 
}

/*  FUNCTION AXIOS FOR CONNECTION LOGIN AND SIGNUP */

import axios from "axios"
export function postConnection (connectionType, post, errorMessage) {
    const data = JSON.stringify(post)
      axios.post("http://localhost:3000/api/" + connectionType, data, {
        headers: {
          "content-type": "application/json",
        },
      }) 
      .then(response => {
        
        sessionStorage.setItem('token', response.data.token)
        sessionStorage.setItem('userId', response.data.userId)
        sessionStorage.setItem('pseudo', response.data.pseudo)
        sessionStorage.setItem('role', response.data.role)
        window.open('/home', '_self')

      })
      .catch((error) => errorMessage = error.response.data.message)
}

