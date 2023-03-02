import http from 'k6/http';
import { group } from 'k6';

// Import Test Requirements
import {thresholds} from "./testRequirements/SLA.js";

// Import Load Scenario
// import {stages} from "./loadScenario/general/short/load.js";
// import {stages} from "./loadScenario/general/spike/load.js";
import {stages} from "./loadScenario/general/soak/load.js";
// import {stages} from "./loadScenario/general/stress/load.js";

// Import Test Case
import {login} from "./testCase/services/login/login.js";
import {logout} from "./testCase/services/login/logout.js";

import {findOwners} from "./testCase/spring-petclinic/services/Owners/findOwners.js";
import {makeError} from "./testCase/spring-petclinic/services/makeError/makeError.js";


export const options = {
    stages: stages,
    threshold: thresholds
}


export default function () {
    const protocol = "http" // http or https
    const target = protocol+`://${__ENV.SERVER_HOST}/`


    group('findOwner',() => {
        findOwners(target)
        findOwners(target)
        findOwners(target)
    });

    group('makeError',() => {
        makeError(target)
    });
}