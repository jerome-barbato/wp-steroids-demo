import {axios} from "axios";

let ajax_url = document.head.querySelector('meta[name="home-url"]').content+'/api'

export default {

    getData(data){

        return new Promise((resolve, reject) => {

            data.action = 'getData';

            axios.post(ajax_url, data, {emulateJSON:true}).then(response => {

                resolve(response.body);

            },reject)
        })
    },
}