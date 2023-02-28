export const thresholds = {
    http_req_duration: ['p(95) < 700', 'p(99) < 1000', 'p(99.9) < 2000'],
    http_req_failed: ['rate < 0.01'] // 99% 사용자는 제대로 응답을 받아야한다.
}