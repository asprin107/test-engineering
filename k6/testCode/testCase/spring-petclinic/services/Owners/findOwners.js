import http from 'k6/http';
import { check, sleep } from 'k6';

export function findOwners(host) {
    const url = host+'owners?lastName=';
    const result = http.get(url)

    // Validate
    // check(result, {
    //     'http response status code is 200': (r) => r.status === 200,
    // })
    // let errorRate = new Rate("errors");
    check(result, {
        'http response status code is 200': (r) => r.status === 200,
    })
    // if (!success) {
    //     errorRate.add(1)
    // }

    sleep(1);
}

