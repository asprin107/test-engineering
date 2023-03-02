import http from 'k6/http';
import { check, sleep } from 'k6';

export function logout(host) {
    const url = host+'booking-mvc/logout';
    const result = http.get(url, {
            headers: {
                host: 'localhost:8080',
                'user-agent':
                    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/110.0',
                accept:
                    'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
                'accept-language': 'en-US,en;q=0.5',
                'accept-encoding': 'gzip, deflate, br',
                dnt: '1',
                connection: 'keep-alive',
                referer: 'http://localhost:8080/booking-mvc/hotels/search',
                cookie:
                    'JSESSIONID=node01xsauo72sohty197olfxmzre548.node0; _ga=GA1.1.1818368809.1676451525',
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
        'http response status code is 200': result.status === 200,
    });

    sleep(1)
}