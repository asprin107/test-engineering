import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    stages: [
        { target: 100, duration: '1m' },
        { target: 50, duration: '1m' },
        { target: 0, duration: '30s' },
    ],
};

export default function () {
    const result = http.get('https://test-api.k6.io/public/crocodiles/');
    check(result, {
        'http response status code is 200': result.status === 200,
    });
    sleep(1)
}