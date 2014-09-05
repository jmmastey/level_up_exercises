/**
 * Created by jbonfante on 8/26/14.
 */

//var bombServices = ['Activation', 'Deactivation', 'DetonationTime'];
//
//for (var __service in bombServices)
//{
//    bombApp.factory(__service, function($resource) {
//        return $resource("/"+__service.toLowerCase()+"/:code", { code: "@"+__service.toLowerCase()+"code" },
//            {
//                'create':  { method: 'POST' },
//                'index':   { method: 'GET', isArray: true },
//                'show':    { method: 'GET', isArray: false },
//                'update':  { method: 'PUT' },
//                'destroy': { method: 'DELETE' }
//            }
//        );
//    });
//}

bombApp.factory("Bomb", function($resource) {
    return $resource("/bomb",{},
        {
            'activationCode':  { method: 'POST' },
            'deactivationCode':  { method: 'POST', url:"/bomb/deactivate/:deactivationCode", params:{deactivationCode:"@deactivationCode"} },
            'submitCodes': {method: 'POST', isObject:true,
                url:"/bomb/:activationCode/:deactivationCode/:detonationCode",
            params:{activationCode: "@activationCode", deactivationCode:"@deactivationCode", detonationCode:"@detonationCode"}},
            'deactivation':{method: 'POST'},
            'detonation':  { method: 'POST' },
            'index':   { method: 'GET', isArray: true },
            'show':    { method: 'GET', isArray: false },
            'update':  { method: 'PUT' },
            'explode': { method: 'GET' }
        }
    );
});