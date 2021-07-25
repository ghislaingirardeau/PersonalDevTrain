export function emotionsColor (emotion) {
    let index = 0 /* envoie l'index a l'objet */
    const object = document.getElementsByClassName(`Vector`)
    /* Ajout une class appear a chaque index tant que index est inferieur au nombre d'emotions */
        
    do {
        object[index].classList.add("appear")
        object[index].style.animationDelay = `${index * 0.2}s`;
        /* envoie une couleur suivant emotion negative */
        
        switch (emotion[index]) {
            
            case 'fear' : object[index].setAttribute('fill', '#d12d17') /* red */
            break;
            case 'scared':
            case 'terrifier':    
            case 'insecure':
            case 'nervous':
            case 'horrfied': object[index].setAttribute('fill', '#de5745')
            break;
            case 'anger': object[index].setAttribute('fill', '#d18417') /* orange */
            break;
            case 'disgusted':
            case 'enraged':    
            case 'irritable':
            case 'exasperated':
            case 'jealous': object[index].setAttribute('fill', '#de9e45')
            break;
            case 'sadness': object[index].setAttribute('fill', '#ebd61a') /* yellow */
            break;
            case 'hurt':
            case 'unhappy':    
            case 'disappointed':
            case 'shameful':
            case 'gloomy':
            case 'lonely': object[index].setAttribute('fill', '#d1c341') 
            break;
            case 'surprise': object[index].setAttribute('fill', '#171ad1') /* blue */
            break;  
            case 'confused':
            case 'overcome':    
            case 'stunned':
            case 'amazed':
            case 'moved': object[index].setAttribute('fill', '#4548de') 
            break;
            case 'joy': object[index].setAttribute('fill', '#46d117') /* green */
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
            case 'love': object[index].setAttribute('fill', '#17d1c5') /* turquoise hsv 89%, 82% */
            break;
            case 'sentimental':
            case 'affectionate':    
            case 'romantic':
            case 'enchanted':
            case 'grateful': object[index].setAttribute('fill', '#45ded4') /* hsv 69%, 87% */
        }
        
        index++
    } while(index < (emotion.length))
}