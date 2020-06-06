# kubectl-podevents
[![GitHub Release](https://img.shields.io/github/release/alecjacobs5401/kubectl-podevents.svg?logo=github&style=flat-square)](https://github.com/alecjacobs5401/kubectl-podevents/releases/latest)

[kubectl plugins](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/) for viewing all events for your pods.

The idea for this plugins has been shamelessly stolen from [Melanie Cebula's QCOn London Talk](https://www.infoq.com/presentations/airbnb-kubernetes-services/) and enhanced to be _slightly_ less opinionated.

The plugin plugin displays all pod events for pods in your currently configured namespace.

The plugin also supports standard Pod selection arguments as well as one (or multiple pod names) to explicitly grab events for.

## Installation

Installation steps will install both `kubectl-podevents` and `kubectl-podevents`

### Using [krew](https://github.com/kubernetes-sigs/krew/)
```
kubectl krew install podevents
```

### Manually for Mac / Linux
```
curl -sL https://raw.githubusercontent.com/alecjacobs5401/kubectl-podevents/master/install.sh | sh -s
```

### Manually for Windows

Download Windows binaries from [releases](https://github.com/alecjacobs5401/kubectl-podevents/releases)

## Upgrading

### Using [krew](https://github.com/kubernetes-sigs/krew/)
```
kubectl krew upgrade podevents
```
See installation.

## Usage

```
usage: kubectl podevents [<flags>] [<pod>...]

A kubectl plugin used to view pod events for the given pod selector

Flags:
  -h, --help                   Show context-sensitive help (also try --help-long and --help-man).
      --version                Show application version.
  -l, --selector=SELECTOR      Pod Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
      --field-selector=FIELD-SELECTOR
                               Pod Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector key1=value1,key2=value2). The server only supports a limited number of field queries per type.
      --event-selector=EVENT-SELECTOR
                               Pod Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
      --event-field-selector=EVENT-FIELD-SELECTOR
                               Event Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector key1=value1,key2=value2). The server only supports a limited number of field queries per type.
      --kubeconfig=KUBECONFIG  The path to a pre-existing kubeconfig file that you want to have the new cluster authorization merged into. If not provided, the KUBECONFIG environment variable will be checked for a file. If that is empty, $HOME/.kube/config will be used.
  -n, --namespace=NAMESPACE    The Kubernetes namespace to use. Default to the current namespace in your kube config file.
      --context=CONTEXT        The Kubernetes context to use. Defaults to the current context in your kube config file.

Args:
  [<pod>]  A pod name to target (Accepts multiple pod names)
```

## Example Usages
### Without Arguments / Flags
```
$ kubectl podevents
Events for bad-pod-764ccf854d-kbsq2:
LAST SEEN			TYPE	REASON		    	MESSAGE
2020-05-29 14:15:32 -0700 PDT	Warning	DNSConfigForming	Search Line limits were exceeded, some search paths have been omitted, the applied search line is: ajacobs-playground.svc.cluster.local svc.cluster.local cluster.local ec2.internal us-east-1.invocadev.com invocadev.com

Events for redis-59b66855fc-94sn9:
LAST SEEN			TYPE	REASON		    	MESSAGE
2020-05-29 14:17:33 -0700 PDT	Warning	DNSConfigForming	Search Line limits were exceeded, some search paths have been omitted, the applied search line is: ajacobs-playground.svc.cluster.local svc.cluster.local cluster.local ec2.internal us-east-1.invocadev.com invocadev.com
```


### Diagnosing based on Pod Names
```
kubectl podevents pod-abc-123 pod-def-456
```

### With event-field-selector
```
# filters out events with a reason of DNSConfigForming
kubectl podevents --event-field-selector reason!=DNSConfigForming
```
