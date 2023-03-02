import http from 'k6/http';
import { check, sleep } from 'k6';

export function login(host) {
    const url = host+'booking-mvc/loginProcess';
    const result = http.post(
        url,
        {
            _csrf: '714a9756-94c8-42ad-9fe3-db9826f9e7aa',
            username: 'keith',
            password: 'melbourne',
        },
        {
            headers: {
                host: 'localhost:8080',
                'user-agent':
                    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/110.0',
                accept:
                    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
                'accept-language': 'en-US,en;q=0.5',
                'accept-encoding': 'gzip, deflate, br',
                'content-type': 'application/x-www-form-urlencoded',
                origin: host,
                dnt: '1',
                connection: 'keep-alive',
                referer: host+'/booking-mvc/login',
                cookie:
                    'JSESSIONID=node01a9fj7u1go3bpum7e73msdsb3.node0; _ga=GA1.1.1818368809.1676451525',
                'upgrade-insecure-requests': '1',
                'sec-fetch-dest': 'document',
                'sec-fetch-mode': 'navigate',
                'sec-fetch-site': 'same-origin',
                'sec-fetch-user': '?1',
            },
        }
    )

    // Validate
    check(result, {
        'http response status code is 200': (r) => r.status === 200,
    })

    sleep(1);
}