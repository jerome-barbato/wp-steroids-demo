import Vue from "vue";

let ajax_url = document.head.querySelector('meta[name="home-url"]').content+'/api'

export default {

    getData(data){

        return new Promise((resolve, reject) => {

            data.action = 'getData';

            Vue.http.post(ajax_url, data, {emulateJSON:true}).then(response => {

                resolve(response.body);

            },reject)
        })
    },
}