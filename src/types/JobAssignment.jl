mutable struct JobAssignment
    J::Job
    M::UInt64     # machine number
    S::Rational{UInt64} # starting time
    C::Rational{UInt64} # completion time
    function JobAssignment(J, M, S, C)
        if S >= C
            error("The execution time must be positive.")
        end
        if M == 0
            error("The machine number must be positive.")
        end
        return new(J, M, S, C)
    end
end

function Base.show(io::IO, A::JobAssignment)
    function rtos(r::Rational)
        if r == Inf
            return "∞"
        elseif denominator(r) == 1
            return string(numerator(r))
        end
        return string(numerator(r), "//", denominator(r))
    end

    printstyled(io, "$(A.J.name)"; bold = true, color = :light_blue)
    print(io, " → ")
    printstyled(io, "M$(A.M)"; bold = true, color = :light_yellow)
    print(io, "[$(rtos(A.S)), $(rtos(A.C)))")
end