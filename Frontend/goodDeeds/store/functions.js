export function EmotionsColor (emotion, object) {
    switch (emotion) {
        case 'fear' : object.setAttribute('fill', '#F53E27') /* red */
        break;
        case 'jealous': object.setAttribute('fill', '#F53E27')
        break;
        case 'anger': object.setAttribute('fill', '#EB9D31') /* orange */
        break;
        case 'anger 2': object.setAttribute('fill', '#EB9D31')
        break;
        case 'sadness': object.setAttribute('fill', '#F7E428') /* yellow */
        break;
        case 'sadness 2': object.setAttribute('fill', '#F7E428') 
        break;
        case 'surprise': object.setAttribute('fill', '#282AF7') /* blue */
        break;
        case 'surprise 2': object.setAttribute('fill', '#282AF7') 
        break;
        case 'joy': object.setAttribute('fill', '#55F522') /* green */
        break;
        case 'happy': object.setAttribute('fill', '#55F522')
        break;
        case 'love': object.setAttribute('fill', '#31EBDF') /* turquoise */
        break;
        case 'love 2': object.setAttribute('fill', '#31EBDF')
    }
}