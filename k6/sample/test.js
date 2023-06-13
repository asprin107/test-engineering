import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.1/index.js";

export const options = {
    stages: [
        { target: 100, duration: '30s' },
        { target: 50, duration: '30s' },
        { target: 100, duration: '30s' },
    ],
    thresholds: {
        http_req_duration: ['p(95) < 700', 'p(99) < 1000', 'p(99.9) < 2000'],
        http_req_failed: ['rate < 0.05'] // 95% 사용자는 제대로 응답을 받아야한다.
    }
};

export default function () {
    // success()
    // fail()
    group('API crocodiles', () => {
        success()
    })

    group('API Failed', () => {
        fail()
    })
}

function success () {
    const result = http.get('https://test-api.k6.io/public/crocodiles/');
    check(result, {
        'http response status code is 200': result.status === 200,
    });

    sleep(1)
}

function fail() {
    const result = http.post('https://test-api.k6.io/user/register/');
    check(result, {
        'http response status code is 200': result.status === 200,
    });

    sleep(1)
}


export function handleSummary(data) {
    uploadReportToAWS(data)
    return {
        "result.html": htmlReport(data),
        stdout: textSummary(data, { indent: " ", enableColors: true }),
    };
}

function uploadReportToAWS(data) {
    http.put(`https://${__ENV.S3_BUCKET_NAME}/${__ENV.TEST_ID}/${__ENV.HOSTNAME}/result.html`, htmlReport(data))
}