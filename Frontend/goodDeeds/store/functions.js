export function emotionsColor (emotion) {
    let index = 0 /* envoie l'index a l'objet */
    const object = document.getElementsByClassName(`Vector`)
    /* Ajout une class appear a chaque index tant que index est inferieur au nombre d'emotions */
        
    do {
        object[index].classList.add("appear")
        object[index].style.animationDelay = `${index * 0.2}s`;
        /* envoie une couleur suivant emotion negative */
        
        switch (emotion[index]) {
            case 'fear' : object[index].setAttribute('fill', '#F53E27') /* red */
            break;
            case 'jealous': object[index].setAttribute('fill', '#F53E27')
            break;
            case 'anger': object[index].setAttribute('fill', '#EB9D31') /* orange */
            break;
            case 'anger 2': object[index].setAttribute('fill', '#EB9D31')
            break;
            case 'sadness': object[index].setAttribute('fill', '#F7E428') /* yellow */
            break;
            case 'sadness 2': object[index].setAttribute('fill', '#F7E428') 
            break;
            case 'surprise': object[index].setAttribute('fill', '#282AF7') /* blue */
            break;
            case 'surprise 2': object[index].setAttribute('fill', '#282AF7') 
            break;
            case 'joy': object[index].setAttribute('fill', '#55F522') /* green */
            break;
            case 'happy': object[index].setAttribute('fill', '#55F522')
            break;
            case 'love': object[index].setAttribute('fill', '#31EBDF') /* turquoise */
            break;
            case 'love 2': object[index].setAttribute('fill', '#31EBDF')
        }
        
        index++
    } while(index < (emotion.length))
}