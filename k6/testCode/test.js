import http from 'k6/http';
import { check } from 'k6';

// Import Test Requirements
import {thresholds} from "./testRequirements/SLA";
// Import Load Scenario
import {stages} from "./loadScenario/general/short/load";
// Import Test Case
import {login} from "./testCase/services/login/login";
import {logout} from "./testCase/services/login/logout";


export const options = {
    stages: stages,
    threshold: thresholds
}


export default function () {
    const protocol = "https" // http or https
    const target = protocol+`://${__ENV.SERVER_HOST}/`

    login(target)
    logout(target)
}